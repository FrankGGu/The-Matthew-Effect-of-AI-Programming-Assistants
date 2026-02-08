impl Solution {
    pub fn largest_time_from_digits(a: Vec<i32>) -> String {
        let mut a = a;
        a.sort_unstable();
        a.reverse();
        let mut result = String::new();
        for &i in &a {
            for &j in &a {
                if i == j {
                    continue;
                }
                for &k in &a {
                    if k == i || k == j {
                        continue;
                    }
                    for &l in &a {
                        if l == i || l == j || l == k {
                            continue;
                        }
                        let hour = i * 10 + j;
                        let minute = k * 10 + l;
                        if hour < 24 && minute < 60 {
                            return format!("{:02}:{:02}", hour, minute);
                        }
                    }
                }
            }
        }
        result
    }
}