impl Solution {
    pub fn count_time(time: String) -> i32 {
        let mut count = 0;
        let (h1, h2, m1, m2) = (time.chars().nth(0).unwrap(), time.chars().nth(1).unwrap(), time.chars().nth(3).unwrap(), time.chars().nth(4).unwrap());

        for h in 0..24 {
            for m in 0..60 {
                let h_str = format!("{:02}", h);
                let m_str = format!("{:02}", m);
                let valid_time = format!("{}:{}{}", h_str, m_str);

                if valid_time.chars().nth(0).unwrap() == h1 || h1 == '?' {
                    if valid_time.chars().nth(1).unwrap() == h2 || h2 == '?' {
                        if valid_time.chars().nth(3).unwrap() == m1 || m1 == '?' {
                            if valid_time.chars().nth(4).unwrap() == m2 || m2 == '?' {
                                count += 1;
                            }
                        }
                    }
                }
            }
        }
        count
    }
}