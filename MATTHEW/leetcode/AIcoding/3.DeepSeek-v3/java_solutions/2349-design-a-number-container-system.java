class NumberContainers {

    private Map<Integer, TreeSet<Integer>> numToIndices;
    private Map<Integer, Integer> indexToNum;

    public NumberContainers() {
        numToIndices = new HashMap<>();
        indexToNum = new HashMap<>();
    }

    public void change(int index, int number) {
        if (indexToNum.containsKey(index)) {
            int oldNum = indexToNum.get(index);
            numToIndices.get(oldNum).remove(index);
            if (numToIndices.get(oldNum).isEmpty()) {
                numToIndices.remove(oldNum);
            }
        }
        indexToNum.put(index, number);
        numToIndices.computeIfAbsent(number, k -> new TreeSet<>()).add(index);
    }

    public int find(int number) {
        if (numToIndices.containsKey(number)) {
            return numToIndices.get(number).first();
        }
        return -1;
    }
}