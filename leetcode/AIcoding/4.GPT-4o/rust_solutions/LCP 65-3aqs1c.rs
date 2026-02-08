impl Solution {
    pub fn comfortable_temperature(temperature: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut count = [0; 101];

        for &temp in &temperature {
            count[temp as usize] += 1;
        }

        let mut total = 0;
        let mut total_temp = 0;

        for i in 0..=100 {
            if count[i] > 0 {
                total += count[i];
                total_temp += count[i] * i;
            }

            if total > 0 {
                let avg = total_temp / total;
                if avg >= i - 1 && avg <= i + 1 {
                    result.push(i as i32);
                }
            }
        }

        result
    }
}