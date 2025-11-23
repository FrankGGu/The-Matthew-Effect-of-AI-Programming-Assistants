impl Solution {
    pub fn max_value(strs: Vec<String>) -> i64 {
        let n = strs.len();
        let mut max_num = 0;

        for i in 0..n {
            for j in 0..n {
                if i == j {
                    continue;
                }

                let num_str1 = strs[i].clone() + &strs[j].clone();
                let num_str2 = strs[j].clone() + &strs[i].clone();

                let num1 = num_str1.parse::<i64>().unwrap();
                let num2 = num_str2.parse::<i64>().unwrap();

                max_num = max_num.max(num1).max(num2);
            }
        }

        max_num
    }
}