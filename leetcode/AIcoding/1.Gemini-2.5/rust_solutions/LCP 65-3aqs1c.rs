impl Solution {
    pub fn comfortable_humidity(mut humidities: Vec<i32>) -> i32 {
        humidities.sort_unstable();
        let n = humidities.len();
        humidities[(n - 1) / 2]
    }
}