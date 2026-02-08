impl Solution {
    pub fn maximize_square_area(m: i32, n: i32, h_fences: Vec<i32>, v_fences: Vec<i32>) -> i32 {
        let mut h_fences = h_fences;
        let mut v_fences = v_fences;
        h_fences.push(1);
        h_fences.push(m);
        v_fences.push(1);
        v_fences.push(n);

        h_fences.sort();
        v_fences.sort();

        let mut h_gaps = Vec::new();
        for i in 0..h_fences.len() {
            for j in i+1..h_fences.len() {
                h_gaps.push(h_fences[j] - h_fences[i]);
            }
        }

        let mut v_gaps = Vec::new();
        for i in 0..v_fences.len() {
            for j in i+1..v_fences.len() {
                v_gaps.push(v_fences[j] - v_fences[i]);
            }
        }

        h_gaps.sort();
        v_gaps.sort();

        let mut max_area = -1;
        let mut i = h_gaps.len() as i32 - 1;
        let mut j = v_gaps.len() as i32 - 1;

        while i >= 0 && j >= 0 {
            let h = h_gaps[i as usize];
            let v = v_gaps[j as usize];
            if h == v {
                max_area = (h * v) % 1_000_000_007;
                break;
            } else if h > v {
                i -= 1;
            } else {
                j -= 1;
            }
        }

        max_area
    }
}