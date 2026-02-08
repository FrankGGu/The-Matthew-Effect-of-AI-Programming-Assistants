pub fn earliest_full_mark(indices: Vec<i32>, max_time: i32) -> i32 {
    let n = indices.len();
    let mut marked = vec![false; n];
    let mut time = 0;

    for i in 0..n {
        if marked[i] {
            continue;
        }
        time += indices[i];
        if time > max_time {
            return -1;
        }
        marked[i] = true;

        let mut j = (i + 1) % n;
        while j != i {
            time += indices[j];
            if time > max_time {
                return -1;
            }
            marked[j] = true;
            j = (j + 1) % n;
        }
    }

    time
}