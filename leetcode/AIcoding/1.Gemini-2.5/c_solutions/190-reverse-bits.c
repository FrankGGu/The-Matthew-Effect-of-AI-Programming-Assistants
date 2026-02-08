#include <stdint.h>

uint32_t reverseBits(uint32_t n) {
    uint32_t reversed_n = 0;
    for (int i = 0; i < 32; i++) {
        if ((n >> i) & 1) {
            reversed_n |= (1 << (31 - i));
        }
    }
    return reversed_n;
}