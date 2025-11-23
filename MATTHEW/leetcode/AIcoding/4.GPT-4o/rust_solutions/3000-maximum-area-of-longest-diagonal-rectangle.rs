pub fn max_area_of_diagonal_rectangle(lengths: Vec<i32>) -> i32 {
    let mut max_area = 0;
    let n = lengths.len();
    for i in 0..n {
        for j in i + 1..n {
            let width = lengths[i].min(lengths[j]);
            let height = (j - i) as i32;
            max_area = max_area.max(width * height);
        }
    }
    max_area
}