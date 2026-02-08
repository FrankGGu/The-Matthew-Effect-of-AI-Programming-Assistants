impl Solution {
    pub fn minimum_operations(num1: i32, num2: i32) -> i32 {
        if num1 == num2 {
            return 0;
        }

        let s1 = num1.to_string();
        let s2 = num2.to_string();

        let n1 = s1.chars().collect::<Vec<_>>();
        let n2 = s2.chars().collect::<Vec<_>>();

        let mut diff = vec![];
        let mut i = 0;
        let mut j = 0;

        while i < n1.len() || j < n2.len() {
            let d1 = if i < n1.len() { n1[n1.len() - 1 - i].to_digit(10).unwrap() as i32 } else { 0 };
            let d2 = if j < n2.len() { n2[n2.len() - 1 - j].to_digit(10).unwrap() as i32 } else { 0 };

            diff.push((d1 - d2).abs());

            i += 1;
            j += 1;
        }

        diff.reverse();

        let mut ans = 0;
        let mut i = 0;
        while i < diff.len() {
            if diff[i] != 0 {
                ans += 1;
                let mut j = i;
                while j < diff.len() && diff[j] != 0 {
                    j += 1;
                }
                i = j;
            } else {
                i += 1;
            }
        }

        ans
    }
}