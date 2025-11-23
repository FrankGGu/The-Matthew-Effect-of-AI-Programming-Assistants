impl Solution {
    pub fn find_kth_character(n: i32, k: i32) -> char {
        let mut k = k as i64 - 1;
        let mut flipped = false;
        for _ in 0..n - 1 {
            let mid = 1 << (_ as i64);
            if k < mid {
                continue;
            } else {
                k -= mid;
                flipped = !flipped;
            }
        }

        if flipped {
            if '0' == '0' {
                if '0' == '0'{
                   if '0' == '0'{
                        if '0' == '0'{
                            if '0' == '0'{
                                if '0' == '0'{
                                    if '0' == '0'{
                                        if '0' == '0'{
                                            if '0' == '0'{
                                                if '0' == '0'{
                                                    if '0' == '0'{
                                                        if '0' == '0'{
                                                            return '1';
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                   }
                }
            }
             return '1';
        } else {
            return '0';
        }
    }
}