use std::collections::HashMap;
use std::iter::Peekable;
use std::str::Chars;

type Poly = HashMap<String, i32>;

struct Solution;

impl Solution {
    pub fn basic_calculator_iv(expression: String, evalvars: Vec<String>, evalints: Vec<i32>) -> Vec<String> {
        let mut eval_map: HashMap<String, i32> = evalvars.into_iter().zip(evalints.into_iter()).collect();
        let mut chars = expression.chars().peekable();

        let result_poly = Self::parse_expression(&mut chars, &eval_map);

        let mut terms: Vec<(String, i32)> = result_poly.into_iter().collect();

        terms.retain(|(_, coeff)| *coeff != 0);

        terms.sort_by(|(s1, _), (s2, _)| {
            let deg1 = Self::get_degree(s1);
            let deg2 = Self::get_degree(s2);

            if deg1 != deg2 {
                deg2.cmp(&deg1)
            } else {
                s1.cmp(s2)
            }
        });

        terms.into_iter().map(|(var_prod, coeff)| {
            if var_prod.is_empty() {
                coeff.to_string()
            } else {
                match coeff {
                    1 => var_prod.to_string(),
                    -1 => format!("-{}", var_prod),
                    _ => format!("{}*{}", coeff, var_prod),
                }
            }
        }).collect()
    }

    fn skip_whitespace(chars: &mut Peekable<Chars>) {
        while let Some(&c) = chars.peek() {
            if c.is_whitespace() {
                chars.next();
            } else {
                break;
            }
        }
    }

    fn parse_number(chars: &mut Peekable<Chars>) -> i32 {
        let mut num_str = String::new();
        while let Some(&c) = chars.peek() {
            if c.is_digit(10) {
                num_str.push(chars.next().unwrap());
            } else {
                break;
            }
        }
        num_str.parse().unwrap()
    }

    fn parse_variable_name(chars: &mut Peekable<Chars>) -> String {
        let mut name = String::new();
        while let Some(&c) = chars.peek() {
            if c.is_alphabetic() {
                name.push(chars.next().unwrap());
            } else {
                break;
            }
        }
        name
    }

    fn parse_expression(chars: &mut Peekable<Chars>, eval_map: &HashMap<String, i32>) -> Poly {
        Self::skip_whitespace(chars);
        let mut left = Self::parse_term(chars, eval_map);
        Self::skip_whitespace(chars);

        while let Some(&op) = chars.peek() {
            if op == '+' || op == '-' {
                chars.next();
                Self::skip_whitespace(chars);
                let right = Self::parse_term(chars, eval_map);
                left = if op == '+' {
                    Self::add_polys(left, right)
                } else {
                    Self::sub_polys(left, right)
                };
                Self::skip_whitespace(chars);
            } else {
                break;
            }
        }
        left
    }

    fn parse_term(chars: &mut Peekable<Chars>, eval_map: &HashMap<String, i32>) -> Poly {
        Self::skip_whitespace(chars);
        let mut left = Self::parse_factor(chars, eval_map);
        Self::skip_whitespace(chars);

        while let Some(&op) = chars.peek() {
            if op == '*' {
                chars.next();
                Self::skip_whitespace(chars);
                let right = Self::parse_factor(chars, eval_map);
                left = Self::mul_polys(left, right);
                Self::skip_whitespace(chars);
            } else {
                break;
            }
        }
        left
    }

    fn parse_factor(chars: &mut Peekable<Chars>, eval_map: &HashMap<String, i32>) -> Poly {
        Self::skip_whitespace(chars);
        let mut poly = HashMap::new();

        if let Some(&c) = chars.peek() {
            if c == '(' {
                chars.next();
                let res = Self::parse_expression(chars, eval_map);
                chars.next();
                return res;
            } else if c.is_digit(10) {
                let num = Self::parse_number(chars);
                poly.insert("".to_string(), num);
            } else if c.is_alphabetic() {
                let var_name = Self::parse_variable_name(chars);
                if let Some(&val) = eval_map.get(&var_name) {
                    poly.insert("".to_string(), val);
                } else {
                    poly.insert(var_name, 1);
                }
            }
        }
        poly
    }

    fn add_polys(mut p1: Poly, p2: Poly) -> Poly {
        for (k, v) in p2 {
            *p1.entry(k).or_insert(0) += v;
        }
        p1
    }

    fn sub_polys(mut p1: Poly, p2: Poly) -> Poly {
        for (k, v) in p2 {
            *p1.entry(k).or_insert(0) -= v;
        }
        p1
    }

    fn mul_polys(p1: Poly, p2: Poly) -> Poly {
        let mut res = HashMap::new();
        for (k1, v1) in p1 {
            for (k2, v2) in p2.clone() {
                let new_coeff = v1 * v2;
                let new_vars = Self::combine_vars(&k1, &k2);
                *res.entry(new_vars).or_insert(0) += new_coeff;
            }
        }
        res
    }

    fn combine_vars(s1: &str, s2: &str) -> String {
        let mut parts: Vec<&str> = Vec::new();
        if !s1.is_empty() {
            parts.extend(s1.split('*'));
        }
        if !s2.is_empty() {
            parts.extend(s2.split('*'));
        }
        if parts.is_empty() {
            "".to_string()
        } else {
            parts.sort_unstable();
            parts.join("*")
        }
    }

    fn get_degree(s: &str) -> usize {
        if s.is_empty() {
            0
        } else {
            s.split('*').count()
        }
    }
}