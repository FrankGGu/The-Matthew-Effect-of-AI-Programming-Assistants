var decodeAtIndex = function(S, K) {
    let decodedLength = 0n;

    for (let i = 0; i < S.length; i++) {
        const char = S[i];
        if (char >= 'a' && char <= 'z') {
            decodedLength++;
        } else {
            const digit = BigInt(parseInt(char));
            decodedLength *= digit;
        }
    }

    let bigK = BigInt(K);

    for (let i = S.length - 1; i >= 0; i--) {
        const char = S[i];

        bigK %= decodedLength;
        if (bigK === 0n) {
            bigK = decodedLength;
        }

        if (char >= 'a' && char <= 'z') {
            if (bigK === decodedLength) {
                return char;
            }
            decodedLength--;
        } else {
            const digit = BigInt(parseInt(char));
            decodedLength /= digit;
        }
    }
};