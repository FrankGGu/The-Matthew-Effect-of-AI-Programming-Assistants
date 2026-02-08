impl Solution {
    pub fn can_be_equal(target: String, arr: Vec<String>) -> bool {
        let mut target_chars = target.chars().collect::<Vec<_>>();
        let mut arr_chars = arr.iter().flat_map(|s| s.chars()).collect::<Vec<_>>();

        target_chars.sort();
        arr_chars.sort();

        target_chars == arr_chars
    }
}