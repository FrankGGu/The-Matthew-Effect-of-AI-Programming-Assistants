pub fn score_of_students(s: String, answers: Vec<i32>) -> i32 {
    let mut dp = vec![vec![0; 101]; 101];
    let mut valid_scores = std::collections::HashSet::new();

    let eval = |expr: &str| -> i32 {
        let mut stack = vec![];
        let mut num = 0;
        let mut sign = 1; // 1 for '+', -1 for '-'
        let mut ops = vec![];

        for ch in expr.chars() {
            if ch.is_digit(10) {
                num = num * 10 + (ch as i32 - '0' as i32);
            } else {
                if let Some(op) = ops.last() {
                    if *op == '+' {
                        stack.push(num * sign);
                    } else if *op == '-' {
                        stack.push(-num * sign);
                    }
                }
                num = 0;
                if ch == '+' || ch == '-' {
                    ops.push(ch);
                }
                sign = if ch == '+' { 1 } else { -1 };
            }
        }
        if let Some(op) = ops.last() {
            if *op == '+' {
                stack.push(num * sign);
            } else {
                stack.push(-num * sign);
            }
        }
        stack.iter().sum()
    };

    let score = eval(&s);
    valid_scores.insert(score);

    let n = s.len();
    for i in 0..n {
        for j in i..n {
            let sub_expr = &s[i..=j];
            let eval_sub = eval(sub_expr);
            valid_scores.insert(eval_sub);
        }
    }

    for ans in answers {
        if valid_scores.contains(&ans) {
            dp[ans as usize][0] += 1;
        }
    }

    let mut total_score = 0;
    for ans in answers {
        if ans == score {
            total_score += 5;
        } else if valid_scores.contains(&ans) {
            total_score += 2;
        }
    }

    total_score
}