use std::collections::HashMap;

impl Solution {
    pub fn group_strings(words: Vec<String>) -> Vec<i32> {
        let mut map: HashMap<i32, i32> = HashMap::new();
        let mut parent: HashMap<i32, i32> = HashMap::new();
        let mut size: HashMap<i32, i32> = HashMap::new();

        for word in &words {
            let mask = Self::get_mask(word);
            parent.insert(mask, mask);
            size.insert(mask, 1);
            map.insert(mask, 1);
        }

        for word in &words {
            let mask = Self::get_mask(word);
            for i in 0..26 {
                let neighbor = mask ^ (1 << i);
                if map.contains_key(&neighbor) {
                    Self::union(&mut parent, &mut size, mask, neighbor);
                }
                for j in i + 1..26 {
                    let neighbor = (mask ^ (1 << i)) | (1 << j);
                    if map.contains_key(&neighbor) {
                        Self::union(&mut parent, &mut size, mask, neighbor);
                    }
                }
            }
        }

        let mut groups = 0;
        let mut maxSize = 0;
        let mut seen: HashMap<i32, bool> = HashMap::new();
        for word in &words {
            let mask = Self::get_mask(word);
            let root = Self::find(&mut parent, mask);
            if !seen.contains_key(&root) {
                groups += 1;
                seen.insert(root, true);
                maxSize = maxSize.max(*size.get(&root).unwrap());
            }
        }

        vec![groups, maxSize]
    }

    fn get_mask(word: &String) -> i32 {
        let mut mask = 0;
        for c in word.chars() {
            mask |= 1 << (c as u8 - b'a');
        }
        mask
    }

    fn find(parent: &mut HashMap<i32, i32>, x: i32) -> i32 {
        let p = *parent.get(&x).unwrap();
        if p != x {
            let root = Self::find(parent, p);
            parent.insert(x, root);
            root
        } else {
            x
        }
    }

    fn union(parent: &mut HashMap<i32, i32>, size: &mut HashMap<i32, i32>, x: i32, y: i32) {
        let rootX = Self::find(parent, x);
        let rootY = Self::find(parent, y);

        if rootX != rootY {
            let sizeX = *size.get(&rootX).unwrap();
            let sizeY = *size.get(&rootY).unwrap();

            if sizeX < sizeY {
                parent.insert(rootX, rootY);
                size.insert(rootY, sizeX + sizeY);
            } else {
                parent.insert(rootY, rootX);
                size.insert(rootX, sizeX + sizeY);
            }
        }
    }
}