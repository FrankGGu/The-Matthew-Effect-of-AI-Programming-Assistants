impl Solution {
    pub fn remove_trailing_zeros(num: String) -> String {
        let mut num = num.chars().collect::<Vec<char>>();
        while let Some(&'0') = num.last() {
            num.pop();
        }
        num.into_iter().collect()
    }
}