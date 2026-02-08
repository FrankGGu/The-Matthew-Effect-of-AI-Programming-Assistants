use pandas::DataFrame;

fn get_size(df: DataFrame) -> Vec<i32> {
    let nrows = df.nrows() as i32;
    let ncols = df.ncols() as i32;
    vec![nrows, ncols]
}