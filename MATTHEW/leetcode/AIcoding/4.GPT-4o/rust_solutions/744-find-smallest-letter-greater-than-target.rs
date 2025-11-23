impl Solution {
    pub fn next_greatest_letter(letters: Vec<char>, target: char) -> char {
        let mut left = 0;
        let mut right = letters.len() as i32 - 1;

        while left <= right {
            let mid = left + (right - left) / 2;
            if letters[mid as usize] <= target {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        letters[left as usize % letters.len()]
    }
}