use std::collections::HashSet;

impl Solution {
    pub fn minimum_number_of_people_to_teach(n: i32, languages: Vec<Vec<i32>>, friendships: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<HashSet<usize>> = vec![HashSet::new(); n + 1];
        for i in 0..friendships.len() {
            let u = friendships[i][0] as usize;
            let v = friendships[i][1] as usize;
            let mut common = false;
            for &lang_u in &languages[u - 1] {
                for &lang_v in &languages[v - 1] {
                    if lang_u == lang_v {
                        common = true;
                        break;
                    }
                }
                if common {
                    break;
                }
            }
            if !common {
                adj[u].insert(v);
                adj[v].insert(u);
            }
        }

        let mut ans = languages.len();
        for lang in 1..=n {
            let mut teach = HashSet::new();
            for i in 1..=languages.len() {
                let mut speaks = false;
                for &l in &languages[i - 1] {
                    if l as usize == lang {
                        speaks = true;
                        break;
                    }
                }
                if speaks {
                    continue;
                }

                for &neighbor in &adj[i] {
                    let mut neighbor_speaks = false;
                    for &l in &languages[neighbor - 1] {
                        if l as usize == lang {
                            neighbor_speaks = true;
                            break;
                        }
                    }
                    if neighbor_speaks {
                        continue;
                    }
                    teach.insert(i);
                }
            }
            ans = ans.min(teach.len());

            let mut teach2 = HashSet::new();
            for i in 1..=languages.len() {
                 let mut speaks = false;
                for &l in &languages[i - 1] {
                    if l as usize == lang {
                        speaks = true;
                        break;
                    }
                }
                if speaks {
                    continue;
                }

                for &neighbor in &adj[i] {
                  teach2.insert(i);
                }
            }
            let mut teach_set = HashSet::new();
            for i in 1..=languages.len() {
                let mut speaks = false;
                for &l in &languages[i - 1] {
                    if l as usize == lang {
                        speaks = true;
                        break;
                    }
                }
                if speaks {
                    continue;
                }
               let mut need_teach = false;
               for j in 1..=languages.len() {
                   if i==j {
                       continue;
                   }
                   let mut speaks2 = false;
                   for &l in &languages[j-1]{
                       if l as usize == lang{
                           speaks2 = true;
                           break;
                       }
                   }
                   if speaks2 {
                       continue;
                   }
                   let u = i as usize;
                   let v = j as usize;
                   let mut common = false;
                   for &lang_u in &languages[u - 1] {
                        for &lang_v in &languages[v - 1] {
                            if lang_u == lang_v {
                                common = true;
                                break;
                            }
                        }
                        if common {
                            break;
                        }
                    }
                    if !common{
                        need_teach = true;
                    }
               }
               if need_teach{
                   teach_set.insert(i);
               }
            }
             ans = ans.min(teach_set.len() as i32);
        }

        ans as i32
    }
}