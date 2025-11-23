impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct DataFrame {
    pub data: Vec<Vec<i32>>,
    pub columns: Vec<String>,
}

impl DataFrame {
    pub fn create_column(mut self, name: String, values: Vec<i32>) -> Self {
        if self.data.is_empty() {
            self.columns.push(name);
            return self;
        }

        if self.data.len() != values.len() {
            panic!("Values length must match number of rows");
        }

        self.columns.push(name);
        for i in 0..self.data.len() {
            self.data[i].push(values[i]);
        }

        self
    }
}
}