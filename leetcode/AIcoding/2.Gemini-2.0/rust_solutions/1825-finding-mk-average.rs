struct MKAverage {
    m: i32,
    k: i32,
    stream: Vec<i32>,
}

impl MKAverage {
    fn new(m: i32, k: i32) -> Self {
        MKAverage {
            m,
            k,
            stream: Vec::new(),
        }
    }

    fn add_element(&mut self, num: i32) {
        self.stream.push(num);
    }

    fn calculate_mk_average(&self) -> i32 {
        if self.stream.len() < self.m as usize {
            return -1;
        }

        if self.stream.len() as i32 == self.m {
            let mut sorted_stream = self.stream.clone();
            sorted_stream.sort();
            let sum: i64 = sorted_stream[(self.k as usize)..(self.m - self.k) as usize].iter().map(|&x| x as i64).sum();
            return (sum / (self.m - 2 * self.k) as i64) as i32;
        }

        let start = self.stream.len() - self.m as usize;
        let end = self.stream.len();
        let mut sub_stream = self.stream[start..end].to_vec();
        sub_stream.sort();

        let sum: i64 = sub_stream[(self.k as usize)..(self.m - self.k) as usize].iter().map(|&x| x as i64).sum();
        (sum / (self.m - 2 * self.k) as i64) as i32
    }
}