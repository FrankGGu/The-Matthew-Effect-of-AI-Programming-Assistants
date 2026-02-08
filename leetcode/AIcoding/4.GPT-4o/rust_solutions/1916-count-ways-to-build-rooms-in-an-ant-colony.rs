pub fn ways_to_build_rooms(prev_room: Vec<i32>) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let n = prev_room.len();
    let mut fact = vec![1; n + 1];
    let mut inv_fact = vec![1; n + 1];

    for i in 2..=n {
        fact[i] = fact[i - 1] * i % MOD;
    }

    inv_fact[n] = mod_inverse(fact[n], MOD);
    for i in (1..n).rev() {
        inv_fact[i] = inv_fact[i + 1] * (i + 1) % MOD;
    }

    let mut tree_size = vec![0; n];
    let mut child_count = vec![0; n];

    for (i, &parent) in prev_room.iter().enumerate() {
        if parent != -1 {
            child_count[parent as usize] += 1;
        }
    }

    fn dfs(node: usize, child_count: &Vec<i32>, tree_size: &mut Vec<i32>) -> i32 {
        let mut total_ways = 1;
        let mut total_size = 1;

        for i in 0..child_count[node] {
            let child = node + i as usize + 1;
            let size = dfs(child, child_count, tree_size);
            total_ways = total_ways * size % MOD;
            total_size += size;
        }

        tree_size[node] = total_size;
        total_ways * fact[total_size - 1] % MOD * inv_fact[total_size - 1 - child_count[node]] % MOD
            * inv_fact[child_count[node]] % MOD
    }

    dfs(0, &child_count, &mut tree_size)
}
fn mod_inverse(a: i32, m: i32) -> i32 {
    let mut m0 = m;
    let mut y = 0;
    let mut x = 1;

    if m == 1 {
        return 0;
    }

    let mut a = a % m;

    while a > 1 {
        let q = a / m0;
        let t = m0;
        m0 = a % m0;
        a = t;
        let t = y;
        y = x - q * y;
        x = t;
    }

    if x < 0 {
        x += m;
    }

    x
}