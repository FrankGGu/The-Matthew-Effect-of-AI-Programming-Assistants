impl Solution {
    pub fn next_greatest_letter(letters: Vec<char>, target: char) -> char {
        let n = letters.len();
        let mut low = 0;
        let mut high = n - 1;
        let mut ans = letters[0]; // Default to the first character for wrap-around case

        while low <= high {
            let mid = low + (high - low) / 2;
            if letters[mid] > target {
                ans = letters[mid];
                if mid == 0 { // Optimization: if the first element is already greater, it's the answer
                    return ans;
                }
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }
}