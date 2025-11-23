struct Solution;

impl Solution {
    pub fn vowel_strings(strs: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut prefix = vec![0; strs.len() + 1];

        for i in 0..strs.len() {
            let s = &strs[i];
            let first = s.chars().next().unwrap();
            let last = s.chars().last().unwrap();
            let count = if "aeiou".contains(first) && "aeiou".contains(last) { 1 } else { 0 };
            prefix[i + 1] = prefix[i] + count;
        }

        let mut result = Vec::with_capacity(queries.len());
        for q in queries {
            let left = q[0] as usize;
            let right = q[1] as usize;
            result.push(prefix[right + 1] - prefix[left]);
        }

        result
    }
}