var originalDigits = function(s) {
    const charCounts = new Map();
    for (const char of s) {
        charCounts.set(char, (charCounts.get(char) || 0) + 1);
    }

    const digitCounts = new Array(10).fill(0);

    // Identify digits based on unique characters
    // 'z' is unique to 'zero' (0)
    digitCounts[0] = charCounts.get('z') || 0;
    // 'w' is unique to 'two' (2)
    digitCounts[2] = charCounts.get('w') || 0;
    // 'u' is unique to 'four' (4)
    digitCounts[4] = charCounts.get('u') || 0;
    // 'x' is unique to 'six' (6)
    digitCounts[6] = charCounts.get('x') || 0;
    // 'g' is unique to 'eight' (8)
    digitCounts[8] = charCounts.get('g') || 0;

    // Identify digits based on characters that become unique after accounting for the first set
    // 'h' is in 'three' and 'eight'. After 'eight' is counted, remaining 'h's are for 'three'.
    digitCounts[3] = (charCounts.get('h') || 0) - digitCounts[8];
    // 'f' is in 'five' and 'four'. After 'four' is counted, remaining 'f's are for 'five'.
    digitCounts[5] = (charCounts.get('f') || 0) - digitCounts[4];
    // 's' is in 'six' and 'seven'. After 'six' is counted, remaining 's's are for 'seven'.
    digitCounts[7] = (charCounts.get('s') || 0) - digitCounts[6];

    // Identify remaining digits
    // 'o' is in 'zero', 'one', 'two', 'four'. After 'zero', 'two', 'four' are counted, remaining 'o's are for 'one'.
    digitCounts[1] = (charCounts.get('o') || 0) - digitCounts[0] - digitCounts[2] - digitCounts[4];
    // 'i' is in 'five', 'six', 'eight', 'nine'. After 'five', 'six', 'eight' are counted, remaining 'i's are for 'nine'.
    digitCounts[9] = (charCounts.get('i') || 0) - digitCounts[5] - digitCounts[6] - digitCounts[8];

    let result = [];
    for (let i = 0; i < 10; i++) {
        for (let j = 0; j < digitCounts[i]; j++) {
            result.push(i);
        }
    }

    return result.join('');
};