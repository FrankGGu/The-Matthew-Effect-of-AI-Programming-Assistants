use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
struct DataFrame {
    dat: Vec<Vec<i32>>,
}

impl DataFrame {
    fn new_column(&mut self, new_col: Vec<i32>) -> Vec<Vec<i32>> {
        if self.dat.is_empty() {
            self.dat.push(new_col);
        } else {
            if self.dat[0].len() != new_col.len() {
                return self.dat.clone();
            }

            for i in 0..self.dat.len() {
                self.dat[i].push(new_col[i]);
            }
        }

        self.dat.clone()
    }
}