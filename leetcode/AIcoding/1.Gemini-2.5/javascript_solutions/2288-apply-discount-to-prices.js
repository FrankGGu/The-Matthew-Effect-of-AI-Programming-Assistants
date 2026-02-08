var discountPrices = function(sentence, discount) {
    const words = sentence.split(' ');
    const discountedWords = [];

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        if (word.length > 1 && word[0] === '$') {
            const priceStr = word.substring(1);

            // Check if priceStr consists only of digits and is a valid non-negative integer without leading zeros.
            // A price like "$0" is valid, but "$05" is not.
            const isValidPriceNumber = priceStr.length > 0 && 
                                       /^\d+$/.test(priceStr) && 
                                       (priceStr === '0' || priceStr[0] !== '0');

            if (isValidPriceNumber) {
                const price = parseInt(priceStr, 10);
                const discountedPrice = price * (1 - discount / 100);
                discountedWords.push('$' + discountedPrice.toFixed(2));
            } else {
                // Not a valid price format, keep the original word.
                discountedWords.push(word);
            }
        } else {
            // Not starting with '$' or too short to be a valid price, keep the original word.
            discountedWords.push(word);
        }
    }

    return discountedWords.join(' ');
};