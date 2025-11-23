impl Solution {
    pub fn is_palindrome(x: i32) -> bool {
        if x < 0 || (x % 10 == 0 && x != 0) {
            return false;
        }

        let mut num = x;
        let mut reverted_number = 0;

        while num > reverted_number {
            reverted_number = reverted_number * 10 + num % 10;
            num /= 10;
        }

        num == reverted_number || num == reverted_number / 10
    }
}