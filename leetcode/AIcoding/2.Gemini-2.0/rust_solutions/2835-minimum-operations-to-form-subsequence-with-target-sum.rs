impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: i32) -> i32 {
        if target == 0 {
            return 0;
        }

        let mut sum: i64 = 0;
        let mut bits: Vec<i32> = Vec::new();
        for &num in &nums {
            sum += num as i64;
            bits.push(num);
        }

        if sum < target as i64 {
            return -1;
        }

        bits.sort();

        let mut current_sum: i32 = 0;
        let mut ops: i32 = 0;
        let mut needed: i32 = 0;

        for i in 0..32 {
            if (target >> i) & 1 == 1 {
                needed = 1 << i;
                let mut found = false;
                for j in 0..bits.len() {
                    if bits[j] == needed {
                        bits.remove(j);
                        current_sum += needed;
                        found = true;
                        break;
                    }
                }

                if !found {
                    let mut k = i + 1;
                    while k < 32 {
                        let mut found_larger = false;
                        let needed_larger = 1 << k;
                        for j in 0..bits.len() {
                            if bits[j] == needed_larger {
                                bits.remove(j);
                                let mut current = needed_larger;
                                while current > needed {
                                    current /= 2;
                                    bits.push(current);
                                    ops += 1;
                                }
                                current_sum += needed;
                                found_larger = true;
                                break;
                            }
                        }
                        if found_larger {
                            break;
                        }
                        k += 1;
                    }
                    if k == 32 {
                        return -1;
                    }
                }
            }

            let mut next_bits: Vec<i32> = Vec::new();
            let mut carry = 0;
            for &bit in &bits {
                if bit & 1 == 1 {
                    carry += 1;
                } else {
                    next_bits.push(bit / 2);
                }
            }

            for _ in 0..carry / 2 {
                next_bits.push(1 << i);
            }

            bits = next_bits;
        }

        ops
    }
}