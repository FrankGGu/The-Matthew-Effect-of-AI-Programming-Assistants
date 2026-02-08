class Solution {
public:
    int mirrorReflect(int p, int q) {
        int gcd = std::__gcd(p, q);
        int lcm = (p / gcd) * q; 
        if ((lcm / p) % 2 == 0) {
            return 2; 
        } else if ((lcm / q) % 2 == 0) {
            return 0; 
        } else {
            return 1; 
        }
    }
};