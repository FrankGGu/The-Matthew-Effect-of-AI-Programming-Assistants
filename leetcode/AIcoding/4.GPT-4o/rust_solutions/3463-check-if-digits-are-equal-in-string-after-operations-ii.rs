impl Solution {
    pub fn are_equal_after_operations(num1: String, num2: String) -> bool {
        let count1 = num1.chars().filter(|&c| c != '0').count();
        let count2 = num2.chars().filter(|&c| c != '0').count();
        count1 == count2
    }
}