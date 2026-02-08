impl Solution {
    pub fn inventory_management(stock: Vec<i32>, cnt: i32) -> Vec<i32> {
        let mut stock = stock;
        let cnt = cnt as usize;
        if cnt == 0 || stock.len() < cnt {
            return vec![];
        }
        let mut left = 0;
        let mut right = stock.len() - 1;
        let mut pivot_index = Self::partition(&mut stock, left, right);
        while pivot_index != cnt - 1 {
            if pivot_index > cnt - 1 {
                right = pivot_index - 1;
            } else {
                left = pivot_index + 1;
            }
            pivot_index = Self::partition(&mut stock, left, right);
        }
        stock[..cnt].to_vec()
    }

    fn partition(stock: &mut [i32], left: usize, right: usize) -> usize {
        let pivot = stock[left];
        let mut l = left + 1;
        let mut r = right;
        while l <= r {
            while l <= r && stock[l] <= pivot {
                l += 1;
            }
            while l <= r && stock[r] > pivot {
                r -= 1;
            }
            if l <= r {
                stock.swap(l, r);
                l += 1;
                r -= 1;
            }
        }
        stock.swap(left, r);
        r
    }
}