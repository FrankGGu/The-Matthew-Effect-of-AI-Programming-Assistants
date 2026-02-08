function bitwiseComplement(N) {
    const binaryString = N.toString(2);
    let complementString = '';

    for (let char of binaryString) {
        complementString += char === '0' ? '1' : '0';
    }

    return parseInt(complementString, 2);
}