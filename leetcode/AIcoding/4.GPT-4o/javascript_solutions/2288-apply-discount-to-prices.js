function discountPrices(sentence, discount) {
    const words = sentence.split(' ');
    const discountedWords = words.map(word => {
        if (word.startsWith('$') && !isNaN(word.slice(1))) {
            const price = parseFloat(word.slice(1));
            const newPrice = (price * (100 - discount) / 100).toFixed(2);
            return `$${newPrice}`;
        }
        return word;
    });
    return discountedWords.join(' ');
}