var numberOfPowerfulInt = function(start, finish, limit, s) {
    const s_len = s.length;

    if (s_len > limit) {
        return 0;
    }

    let count = 0;
    const bigIntStart = BigInt(start);
    const bigIntFinish = BigInt(finish);

    for (let k = 1; ; k++) {
        const current_len = k * s_len;

        if (current_len > limit) {
            break;
        }

        const current_powerful_str = s.repeat(k);
        const current_powerful_num = BigInt(current_powerful_str);

        if (current_powerful_num >= bigIntStart && current_powerful_num <= bigIntFinish) {
            count++;
        }

        if (current_powerful_num > bigIntFinish) {
            break;
        }
    }

    return count;
};