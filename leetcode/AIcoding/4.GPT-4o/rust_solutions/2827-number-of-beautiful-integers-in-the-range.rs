impl Solution {
    pub fn beautiful_integers(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for num in low..=high {
            let mut freq = [0; 10];
            let mut beautiful = true;
            let mut sum = 0;
            let mut digits = 0;

            let mut n = num;
            while n > 0 {
                let digit = n % 10;
                freq[digit as usize] += 1;
                sum += digit;
                digits += 1;
                n /= 10;
            }

            for &f in &freq {
                if f > 1 {
                    beautiful = false;
                    break;
                }
            }

            if beautiful && sum % digits == 0 {
                count += 1;
            }
        }
        count
    }
}