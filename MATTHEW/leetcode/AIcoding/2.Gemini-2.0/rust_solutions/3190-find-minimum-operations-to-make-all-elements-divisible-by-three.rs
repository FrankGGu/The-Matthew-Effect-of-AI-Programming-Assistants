impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut ones = 0;
        let mut twos = 0;

        for &num in &nums {
            match num % 3 {
                1 => ones += 1,
                2 => twos += 1,
                _ => {}
            }
        }

        if ones == 0 && twos == 0 {
            return 0;
        } else if ones == 0 && twos > 0 {
            if twos >= 3 {
                return 1;
            } else {
                return -1;
            }
        } else if twos == 0 && ones > 0 {
            if ones >= 3 {
                return 1;
            } else {
                return -1;
            }
        } else {
            if ones > 0 && twos > 0 {
                if ones == 1 && twos == 1 {
                    return -1;
                } else if ones == 1 && twos >= 2 {
                    return 1;
                } else if twos == 1 && ones >= 2 {
                    return 1;
                } else {
                    let mut ans = i32::MAX;
                    if ones >= 3 {
                        ans = ans.min(1);
                    }
                    if twos >= 3 {
                        ans = ans.min(1);
                    }
                    if ones >= 1 && twos >= 1 {
                        ans = ans.min(2);
                    } else if ones >= 2 {
                        ans = ans.min(2);
                    } else if twos >= 2 {
                        ans = ans.min(2);
                    }
                    if ans == i32::MAX {
                        return -1;
                    }
                    return ans;
                }
            } else {
                return -1;
            }
        }
    }
}