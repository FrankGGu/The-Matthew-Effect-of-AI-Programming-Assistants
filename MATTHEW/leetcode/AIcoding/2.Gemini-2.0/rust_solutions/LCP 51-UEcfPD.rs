impl Solution {
    pub fn perfect_menu(materials: Vec<i32>, cookbooks: Vec<Vec<i32>>, attribute: Vec<Vec<i32>>, limit: i32) -> i32 {
        let n = cookbooks.len();
        let mut ans = -1;
        for mask in 0..(1 << n) {
            let mut cur_materials = materials.clone();
            let mut cur_fat = 0;
            let mut cur_protein = 0;
            let mut count = 0;
            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    count += 1;
                    for j in 0..cur_materials.len() {
                        cur_materials[j] -= cookbooks[i][j];
                        if cur_materials[j] < 0 {
                            count = 0;
                            break;
                        }
                    }
                    if count == 0 {
                        break;
                    }
                    cur_fat += attribute[i][0];
                    cur_protein += attribute[i][1];
                }
            }
            if count > 0 && cur_fat >= limit {
                ans = ans.max(cur_protein);
            }
        }
        ans
    }
}