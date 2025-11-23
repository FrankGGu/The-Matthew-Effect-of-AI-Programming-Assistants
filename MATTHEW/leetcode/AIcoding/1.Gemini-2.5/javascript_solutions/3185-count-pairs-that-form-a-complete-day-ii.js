var countPairsThatFormACompleteDay = function(hours) {
    let count = 0;
    const remainders = new Array(24).fill(0);

    for (const h of hours) {
        const remainder = h % 24;
        const complementRemainder = (24 - remainder) % 24;

        count += remainders[complementRemainder];
        remainders[remainder]++;
    }

    return count;
};