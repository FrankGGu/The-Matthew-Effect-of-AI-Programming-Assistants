impl Solution {
    pub fn create_new_column(dataframe: Vec<Vec<i32>>, operation: String, column_name: String) -> Vec<Vec<i32>> {
        let mut new_dataframe = dataframe;
        let n = new_dataframe.len();
        if n == 0 {
            return new_dataframe;
        }
        let m = new_dataframe[0].len();

        for i in 0..n {
            let mut new_value = 0;
            if operation == "sum" {
                new_value = new_dataframe[i].iter().sum();
            } else if operation == "mean" {
                new_value = new_dataframe[i].iter().sum::<i32>() / m as i32;
            } else if operation == "max" {
                new_value = *new_dataframe[i].iter().max().unwrap();
            } else if operation == "min" {
                new_value = *new_dataframe[i].iter().min().unwrap();
            }
            new_dataframe[i].push(new_value);
        }

        new_dataframe
    }
}