impl Solution {
    pub fn melt(frame: Vec<Vec<String>>) -> Vec<Vec<String>> {
        if frame.is_empty() {
            return Vec::new();
        }
        let mut result = Vec::new();
        let id_vars = &frame[0];
        let num_id_vars = id_vars.len() - 2;
        let mut headers = Vec::new();
        headers.extend_from_slice(&id_vars[..num_id_vars]);
        headers.push("variable".to_string());
        headers.push("value".to_string());
        result.push(headers);

        for row in frame.iter().skip(1) {
            let id_part = &row[..num_id_vars];
            let var1 = &id_vars[num_id_vars];
            let val1 = &row[num_id_vars];
            let var2 = &id_vars[num_id_vars + 1];
            let val2 = &row[num_id_vars + 1];

            let mut row1 = id_part.to_vec();
            row1.push(var1.clone());
            row1.push(val1.clone());
            result.push(row1);

            let mut row2 = id_part.to_vec();
            row2.push(var2.clone());
            row2.push(val2.clone());
            result.push(row2);
        }

        result
    }
}