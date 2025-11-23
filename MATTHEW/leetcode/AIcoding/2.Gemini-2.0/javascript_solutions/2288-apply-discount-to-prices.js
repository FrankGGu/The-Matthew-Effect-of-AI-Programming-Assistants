var discountPrices = function(sentence, discount) {
    const words = sentence.split(" ");
    const discountedWords = words.map(word => {
        if (word.startsWith("$") && word.length > 1 && !isNaN(Number(word.slice(1)))) {
            const price = Number(word.slice(1));
            const discountedPrice = price * (1 - discount / 100);
            return "$" + discountedPrice.toFixed(2);
        } else {
            return word;
        }
    });
    return discountedWords.join(" ");
};