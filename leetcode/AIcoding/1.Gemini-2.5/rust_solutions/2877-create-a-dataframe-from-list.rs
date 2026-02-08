struct DataFrame {
    columns: Vec<String>,
    data: Vec<Vec<String>>,
}

impl DataFrame {
    fn new(data: Vec<Vec<String>>, columns: Vec<String>) -> Self {
        DataFrame {
            columns,
            data,
        }
    }
}