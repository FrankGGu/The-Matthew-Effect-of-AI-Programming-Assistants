struct DataFrame {
    data: Vec<Vec<i32>>,
}

impl DataFrame {
    fn new(data: Vec<Vec<i32>>) -> Self {
        DataFrame { data }
    }

    fn get_size(&self) -> (usize, usize) {
        let rows = self.data.len();
        let cols = if rows > 0 { self.data[0].len() } else { 0 };
        (rows, cols)
    }
}