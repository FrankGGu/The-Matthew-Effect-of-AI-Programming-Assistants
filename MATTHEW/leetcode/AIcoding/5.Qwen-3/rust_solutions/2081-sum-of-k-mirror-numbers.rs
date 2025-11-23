struct Solution;

impl Solution {
    pub fn k_mirror(k: i32) -> i32 {
        let mut count = 0;
        let mut num = 1;

        while true {
            if is_k_mirror(num, k) {
                count += 1;
                if count == k {
                    return num;
                }
            }
            num += 1;
        }
    }

    fn is_k_mirror(mut num: i32, k: i32) -> bool {
        let mut temp = num;
        let mut reversed = 0;

        while temp > 0 {
            reversed = reversed * 10 + temp % 10;
            temp /= 10;
        }

        if reversed != num {
            return false;
        }

        let mut base_k = 0;
        let mut temp = num;

        while temp > 0 {
            base_k = base_k * k + temp % k;
            temp /= k;
        }

        let mut reversed_k = 0;
        temp = base_k;

        while temp > 0 {
            reversed_k = reversed_k * k + temp % k;
            temp /= k;
        }

        reversed_k == base_k
    }
}