impl Solution {
    pub fn is_happy(n: i32) -> bool {
        let mut seen = std::collections::HashSet::new();
        let mut num = n;

        while !seen.contains(&num) {
            seen.insert(num);
            let mut sum = 0;
            let mut temp = num;
            while temp > 0 {
                let digit = temp % 10;
                sum += digit * digit;
                temp /= 10;
            }
            num = sum;

            if num == 1 {
                return true;
            }
        }

        false
    }
}