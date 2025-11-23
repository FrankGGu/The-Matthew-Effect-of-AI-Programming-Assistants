impl Solution {
    pub fn largest_time_from_digits(a: Vec<i32>) -> String {
        let mut max_h = -1;
        let mut max_m = -1;

        for i in 0..4 {
            for j in 0..4 {
                if j == i { continue; }
                for k in 0..4 {
                    if k == i || k == j { continue; }
                    for l in 0..4 {
                        if l == i || l == j || l == k { continue; }

                        let h1 = a[i];
                        let h2 = a[j];
                        let m1 = a[k];
                        let m2 = a[l];

                        let h = h1 * 10 + h2;
                        let m = m1 * 10 + m2;

                        if h < 24 && m < 60 {
                            if max_h == -1 || h * 60 + m > max_h * 60 + max_m {
                                max_h = h;
                                max_m = m;
                            }
                        }
                    }
                }
            }
        }

        if max_h == -1 {
            "".to_string()
        } else {
            format!("{:02}:{:02}", max_h, max_m)
        }
    }
}