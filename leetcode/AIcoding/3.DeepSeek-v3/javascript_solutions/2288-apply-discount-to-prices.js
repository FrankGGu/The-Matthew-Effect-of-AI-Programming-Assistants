var discountPrices = function(sentence, discount) {
    const words = sentence.split(' ');
    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word.startsWith('$') && word.length > 1) {
            const numStr = word.substring(1);
            if (/^\d+$/.test(numStr)) {
                const num = parseFloat(numStr);
                const discounted = num * (100 - discount) / 100;
                words[i] = '$' + discounted.toFixed(2);
            }
        }
    }
    return words.join(' ');
};