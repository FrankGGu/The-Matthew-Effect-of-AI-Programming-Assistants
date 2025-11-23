pub fn count_servers(servers: Vec<Vec<i32>>) -> i32 {
    let mut row_count = vec![0; servers.len()];
    let mut col_count = vec![0; servers[0].len()];

    for i in 0..servers.len() {
        for j in 0..servers[i].len() {
            if servers[i][j] == 1 {
                row_count[i] += 1;
                col_count[j] += 1;
            }
        }
    }

    let mut total = 0;

    for i in 0..servers.len() {
        for j in 0..servers[i].len() {
            if servers[i][j] == 1 && (row_count[i] > 1 || col_count[j] > 1) {
                total += 1;
            }
        }
    }

    total
}