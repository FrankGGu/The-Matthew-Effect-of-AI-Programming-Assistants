function findXorBeauty(nums) {
    let xor = 0;
    for (let num of nums) {
        xor ^= num;
    }
    let beauty = 0;
    for (let num of nums) {
        beauty += xor ^ num;
    }
    return beauty;
}