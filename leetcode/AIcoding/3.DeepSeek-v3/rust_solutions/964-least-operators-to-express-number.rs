impl Solution {
    pub fn least_ops_express_target(x: i32, target: i32) -> i32 {
        let mut target = target;
        let mut pos = 0;
        let mut neg = 0;
        let mut k = 0;

        while target > 0 {
            let curr = target % x;
            target /= x;

            if k == 0 {
                pos = curr * 2;
                neg = (x - curr) * 2;
            } else {
                let new_pos = std::cmp::min(curr * k + pos, (curr + 1) * k + neg);
                let new_neg = std::cmp::min((x - curr) * k + pos, (x - curr - 1) * k + neg);
                pos = new_pos;
                neg = new_neg;
            }

            k += 1;
        }

        std::cmp::min(pos, k + neg) - 1
    }
}