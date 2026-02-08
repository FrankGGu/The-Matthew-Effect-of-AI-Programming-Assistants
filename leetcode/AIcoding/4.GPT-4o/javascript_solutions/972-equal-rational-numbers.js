function isRationalEqual(S, T) {
    function parse(s) {
        let [integerPart, fractionalPart] = s.split('.').map(num => num || '');
        let result = integerPart.replace(/^0+/, '');
        if (fractionalPart) {
            let [nonRepeating, repeating] = fractionalPart.split('(');
            result += nonRepeating.replace(/0+$/, '');
            if (repeating) {
                repeating = repeating.replace(/\)$/,'');
                result += repeating.repeat(20).replace(/0+$/, '');
            }
        }
        return parseFloat(result);
    }
    return parse(S) === parse(T);
}