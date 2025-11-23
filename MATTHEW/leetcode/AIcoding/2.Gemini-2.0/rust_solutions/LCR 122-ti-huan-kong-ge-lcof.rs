impl Solution {
    pub fn path_encryption(path: String) -> String {
        path.replace(".", "dot").replace("/", "slash")
    }
}