struct RangeFreqQuery {
    arr: Vec<i32>,
}

impl RangeFreqQuery {
    fn new(arr: Vec<i32>) -> Self {
        RangeFreqQuery { arr }
    }

    fn query(&self, left: i32, right: i32, value: i32) -> i32 {
        let mut count = 0;
        for i in left as usize..=right as usize {
            if self.arr[i] == value {
                count += 1;
            }
        }
        count
    }
}