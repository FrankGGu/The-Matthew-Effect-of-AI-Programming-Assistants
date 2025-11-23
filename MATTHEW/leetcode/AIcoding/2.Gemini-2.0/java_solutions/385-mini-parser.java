import java.util.List;

class Solution {
    int index = 0;
    String s;

    public NestedInteger deserialize(String s) {
        this.s = s;
        return parse();
    }

    private NestedInteger parse() {
        if (s.charAt(index) == '[') {
            index++;
            NestedInteger nestedList = new NestedIntegerImpl();
            while (s.charAt(index) != ']') {
                nestedList.getList().add(parse());
                if (s.charAt(index) == ',') {
                    index++;
                }
            }
            index++;
            return nestedList;
        } else {
            int sign = 1;
            if (s.charAt(index) == '-') {
                sign = -1;
                index++;
            }
            int num = 0;
            while (index < s.length() && Character.isDigit(s.charAt(index))) {
                num = num * 10 + (s.charAt(index) - '0');
                index++;
            }
            return new NestedIntegerImpl(sign * num);
        }
    }

    private static class NestedIntegerImpl implements NestedInteger {
        private Integer integer;
        private List<NestedInteger> list;

        public NestedIntegerImpl() {
            this.list = new java.util.ArrayList<>();
        }

        public NestedIntegerImpl(int value) {
            this.integer = value;
        }

        @Override
        public boolean isInteger() {
            return integer != null;
        }

        @Override
        public Integer getInteger() {
            return integer;
        }

        @Override
        public List<NestedInteger> getList() {
            return list;
        }
    }
}