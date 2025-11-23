impl Solution {
    pub fn defang_i_p_addr(address: String) -> String {
        address.replace(".", "[.]")
    }
}