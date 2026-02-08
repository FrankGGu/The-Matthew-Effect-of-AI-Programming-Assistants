impl Solution {
    pub fn find_kth_bit(n: i32, k: i32) -> char {
        fn get_bit(n: i32, k: i32) -> char {
            if k == 1 {
                return '0';
            }
            let length = (1 << n) - 1;
            if k == length {
                return '1';
            }
            let mid = (length + 1) / 2;
            if k < mid {
                get_bit(n - 1, k)
            } else {
                let mirror_k = length - k + 1;
                if mirror_k <= mid {
                    if mirror_k == 1 {
                        return '0';
                    }
                    return if get_bit(n - 1, mirror_k) == '0' {
                        '1'
                    } else {
                        '0'
                    };
                } else {
                    return '1';
                }
            }
        }
        get_bit(n, k)
    }
}