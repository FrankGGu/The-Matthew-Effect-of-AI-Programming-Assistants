function maximumRemovals(source, target) {
    let count = 0;
    let i = 0;
    let j = 0;
    const sourceArr = source.split('');
    const targetArr = target.split('');

    while (i < sourceArr.length && j < targetArr.length) {
        if (sourceArr[i] === targetArr[j]) {
            sourceArr[i] = '';
            j++;
        }
        i++;
    }

    return j;
}